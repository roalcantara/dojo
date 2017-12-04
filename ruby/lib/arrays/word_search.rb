# frozen_string_literal: true

require 'set'
require 'thor'
require 'matrix'
require 'colorize'

module Arrays
  module WordSearch
    class Char
      ASCII_ALPHABET_INITIAL_POSITION = 65
      ALPHABET_COUNT = 26

      def self.random_letter
        (ASCII_ALPHABET_INITIAL_POSITION + Random.rand(ALPHABET_COUNT)).chr
      end
    end

    class Dictionary
      attr_reader :file_path

      def initialize(path)
        @file_path = path
        @words = nil
      end

      def words
        @words ||= begin
          @words = Set.new
          File.readlines(@file_path).each do |item|
            @words << item.strip.upcase.split(' ').first
          end
          @words
        end
      end
    end

    class Grid
      attr_reader :file_path, :matrix

      def initialize(values = nil)
        @matrix = Matrix[*values]
      end

      def self.random(n)
        Arrays::WordSearch::Grid.new begin
          Array.new(n).map do
            Array.new(n).map do
              Arrays::WordSearch::Char.random_letter
            end
          end
        end
      end

      def by(orientation: :horizontal)
        case orientation
        when :vertical
          @matrix.transpose
        when :diagonal
          [@matrix.each(orientation).to_a]
        else
          @matrix
        end.to_a
      end

      def find_all(words, orientation: :horizontal, direction: :ltr)
        by(orientation: orientation).flat_map do |value|
          joined = (%i[ltr tb].include?(direction) ? value : value.reverse).join.upcase

          words.find_all do |word|
            joined.include?(word)
          end
        end.compact
      end

      def ==(other)
        return @matrix.to_a == other if other.is_a?(Array)
        other.class == self.class && other.matrix == @matrix
      end

      def to_s
        @matrix.to_a.map do |item|
          item.to_s.delete('"')
        end.join("\n")
      end
    end

    class Result
      attr_reader :words

      def initialize
        @words = {
          horizontal: {
            ltr: [],
            rtl: []
          },
          vertical: {
            tb: [],
            bt: []
          },
          diagonal: {
            ltr: [],
            rtl: []
          }
        }
      end

      def add(words, orientation: :horizontal, direction: :ltr)
        @words[orientation][direction] = words
        @words
      end

      def ==(other)
        return @words == other if other.is_a?(Hash)
        other.class == self.class && other.words == @words
      end
    end

    class Search
      def initialize(grid = nil)
        @grid = grid
      end

      def find_all_words_from(source)
        @result = Arrays::WordSearch::Result.new
        @words = Arrays::WordSearch::Dictionary.new(source).words
        find_all @words, orientation: :horizontal, direction: :ltr
        find_all @words, orientation: :horizontal, direction: :rtl
        find_all @words, orientation: :vertical, direction: :tb
        find_all @words, orientation: :vertical, direction: :bt
        find_all @words, orientation: :diagonal, direction: :ltr
        find_all @words, orientation: :diagonal, direction: :rtl
        @result
      end

      private

      def find_all(words, orientation: :horizontal, direction: :ltr)
        @result.add @grid.find_all(words, orientation: orientation, direction: direction),
                    orientation: orientation, direction: direction
      end
    end
  end
end

class CLI < Thor
  desc 'generate_random_grid', 'Generates a randomly populated the grid'
  option :size, desc: 'The size of the randomly populated the grid'
  def generate_random_grid(size = 0)
    n = (options[:size] || size).to_i
    @grid = Arrays::WordSearch::Grid.random(n)
    puts "\nA RANDOMLY POPULATED GRID [#{n} x #{n}]\n".colorize(:yellow)
    puts "#{@grid.to_s.colorize(:green)}\n\n"
  end

  desc 'find_all_words', 'Generates a randomly populated grid and finds all words from the provided dictionary file'
  option :from, desc: 'The path to the dictionary file'
  option :grid_size, desc: 'The size of the randomly populated the grid'
  def find_all_words
    generate_random_grid(options[:grid_size])
    puts "FINDING WORDS FROM THE DICTIONARY FILE `#{options[:from]}`\n".colorize(:yellow)
    @result = Arrays::WordSearch::Search.new(@grid)
                                        .find_all_words_from options[:from]
    puts log(@result.words)
  end

  private

  # rubocop:disable Metrics/AbcSize
  def log(words)
    [
      'Horizontal words from left to right:',
      words[:horizontal][:ltr].join(', ').colorize(:green),
      "\nHorizontal words from right to left:",
      words[:horizontal][:rtl].join(', ').colorize(:green),
      "\nVertical words from top to bottom:",
      words[:vertical][:tb].join(', ').colorize(:green),
      "\nVertical words from bottom to top:",
      words[:vertical][:bt].join(', ').colorize(:green),
      "\nDiagonal words from left to right:",
      words[:diagonal][:ltr].join(', ').colorize(:green),
      "\nDiagonal words from right to left:",
      words[:diagonal][:rtl].join(', ').colorize(:green),
      "\nYAY! 😎\n".colorize(:yellow)
    ].join("\n")
  end
end

CLI.start
