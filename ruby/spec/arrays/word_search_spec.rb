# frozen_string_literal: true

require 'spec_helper'
require 'arrays/word_search'

# Generate an N x N grid, where N can be any
# number, and randomly populate the grid with letters (A-Z).
#
# Using the provided dictionary file find all:
#
# - Horizontal words from left to right in your grid
# - Horizontal words from right to left in your grid
# - Vertical words from top to bottom in your grid
# - Vertical words from bottom to top in your grid
# - Diagonal words from left to right in your grid
# - Diagonal words from right to left in your grid

RSpec.describe Arrays::WordSearch::Char do
  let(:instance) { Arrays::WordSearch::Char }

  describe '.random_letter' do
    it 'returns a random letter' do
      allow(Random).to receive(:rand).and_return 0

      expect(instance.random_letter).to eq 'A'
    end
  end
end

RSpec.describe Arrays::WordSearch::Dictionary do
  let(:path) { 'spec/fixtures/dict_sample.txt' }
  let(:instance) { Arrays::WordSearch::Dictionary.new path }

  describe '#initialize' do
    it 'initializes with the file from the given path' do
      expect(instance.file_path).to eq path
    end
  end

  describe '#words' do
    subject! { instance.words.to_a }

    it 'returns the loaded words from the given file' do
      is_expected.to eq %w[
        AA ORE AAHS AALII ABACUS BARBIES CANEPHOR LATERALLY GALVANISES RACEMIZATIONS SUPERSTRENGTHS WORTHLESSNESSES
      ]
    end
  end
end

RSpec.describe Arrays::WordSearch::Grid do
  let(:values) { [%w[A A], %w[B B]] }
  let(:instance) { Arrays::WordSearch::Grid.new values }

  describe '.random' do
    let(:n) { 2 }

    before { allow(Arrays::WordSearch::Char).to receive(:random_letter).and_return 'A' }

    subject! { Arrays::WordSearch::Grid.random n }

    it 'generates an N x N grid randomly populates the grid with letters (A-Z)' do
      is_expected.to eq [
        %w[A A],
        %w[A A]
      ]
    end
  end

  describe '#by' do
    let(:orientation) { nil }
    let(:values) do
      [
        %w[A B C],
        %w[D E F],
        %w[G H I]
      ]
    end

    subject! { instance.by orientation: orientation }

    context 'when orientation is :horizontal' do
      let(:orientation) { :horizontal }

      it 'returns the horizontal elements' do
        is_expected.to eq [
          %w[A B C],
          %w[D E F],
          %w[G H I]
        ]
      end
    end

    context 'when orientation is :vertical' do
      let(:orientation) { :vertical }

      it 'returns the vertical elements' do
        is_expected.to eq [
          %w[A D G],
          %w[B E H],
          %w[C F I]
        ]
      end
    end

    context 'when orientation is :diagonal' do
      let(:orientation) { :diagonal }

      it 'returns the diagonal elements' do
        is_expected.to eq [%w[A E I]]
      end
    end
  end

  describe '#find_all' do
    let(:words) { %w[ROUGH ROCK TREE HER TWO] }
    let(:orientation) { :horizontal }
    let(:direction) { :ltr }
    let(:values) do
      [
        %w[T H G U O R],
        %w[O W T R E E],
        %w[R H O U O R],
        %w[O C O R T D],
        %w[C B T C E R],
        %w[K B T C O H]
      ]
    end

    subject! { instance.find_all words, orientation: orientation, direction: direction }

    context 'when orientation is :horizontal' do
      context 'when direction is :ltr' do
        it 'returns the horizontal words from left to right found in the grid' do
          is_expected.to eq %w[TREE]
        end
      end

      context 'when direction is :rtl' do
        let(:direction) { :rtl }

        it 'returns the horizontal words from right to left found in the grid' do
          is_expected.to eq %w[ROUGH TWO]
        end
      end
    end

    context 'when orientation is :vertical' do
      let(:orientation) { :vertical }

      context 'when direction is :tb' do
        let(:direction) { :tb }

        it 'returns the vertical words from top to bottom in the grid' do
          is_expected.to eq %w[ROCK]
        end
      end

      context 'when direction is :bt' do
        let(:direction) { :tb }

        it 'returns the vertical words from bottom to top in the grid' do
          is_expected.to eq %w[ROCK]
        end
      end
    end

    describe 'when orientation is :diagonal' do
      let(:orientation) { :diagonal }

      context 'then direction is :ltr' do
        let(:direction) { :ltr }

        it 'returns the diagonal words from left to right found in the grid' do
          is_expected.to eq %w[TWO]
        end
      end

      context 'then direction is :rtl' do
        let(:direction) { :rtl }

        it 'returns the diagonal words from right to left found in your grid' do
          is_expected.to eq %w[HER]
        end
      end
    end
  end

  describe '#==' do
    let(:other_values) { [%w[D D], %w[C C]] }
    let(:other) { Arrays::WordSearch::Grid.new other_values }

    subject! { instance == other }

    context 'when other has different values' do
      it { is_expected.to be_falsey }
    end

    context 'when other is from any other class' do
      let(:other) { '' }

      it { is_expected.to be_falsey }
    end

    context 'when other has the same values' do
      let(:other_values) { values }

      it { is_expected.to be_truthy }
    end

    context 'when other is an Array' do
      let(:other) { values }

      it 'compares the given Array with the Grid values' do
        is_expected.to be_truthy
      end
    end
  end
end

RSpec.describe Arrays::WordSearch::Result do
  let(:instance) { Arrays::WordSearch::Result.new }
  let(:word) { 'Naruto' }
  let(:orientation) { :horizontal }
  let(:direction) { :ltr }

  describe '#initialize' do
    it 'initializes with an empty result' do
      expect(instance).to eq(
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
      )
    end
  end

  describe '#add' do
    subject! { instance.add word, orientation: orientation, direction: direction }

    context 'when orientation is :horizontal' do
      let(:orientation) { :horizontal }

      context 'when direction is :ltr' do
        let(:direction) { :ltr }

        it 'adds the given word to the horizontal ltr result' do
          is_expected.to eq(
            horizontal: {
              ltr: 'Naruto',
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
          )
        end
      end

      context 'when direction is :rtl' do
        let(:direction) { :rtl }

        it 'adds the given word to the horizontal rtl result' do
          is_expected.to eq(
            horizontal: {
              ltr: [],
              rtl: 'Naruto'
            },
            vertical: {
              tb: [],
              bt: []
            },
            diagonal: {
              ltr: [],
              rtl: []
            }
          )
        end
      end
    end

    context 'when orientation is :vertical' do
      let(:orientation) { :vertical }

      context 'when direction is :tb' do
        let(:direction) { :tb }

        it 'adds the given word to the vertical tb result' do
          is_expected.to eq(
            horizontal: {
              ltr: [],
              rtl: []
            },
            vertical: {
              tb: 'Naruto',
              bt: []
            },
            diagonal: {
              ltr: [],
              rtl: []
            }
          )
        end
      end

      context 'when direction is :bt' do
        let(:direction) { :bt }

        it 'adds the given word to the vertical bt result' do
          is_expected.to eq(
            horizontal: {
              ltr: [],
              rtl: []
            },
            vertical: {
              tb: [],
              bt: 'Naruto'
            },
            diagonal: {
              ltr: [],
              rtl: []
            }
          )
        end
      end
    end

    context 'when orientation is :diagonal' do
      let(:orientation) { :diagonal }

      context 'when direction is :ltr' do
        let(:direction) { :ltr }

        it 'adds the given word to the diagonal ltr result' do
          is_expected.to eq(
            horizontal: {
              ltr: [],
              rtl: []
            },
            vertical: {
              tb: [],
              bt: []
            },
            diagonal: {
              ltr: 'Naruto',
              rtl: []
            }
          )
        end
      end

      context 'when direction is :rtl' do
        let(:direction) { :rtl }

        it 'adds the given word to the diagonal rtl result' do
          is_expected.to eq(
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
              rtl: 'Naruto'
            }
          )
        end
      end
    end
  end

  describe '#==' do
    let(:other_word) { 'Kakashi' }
    let(:other_orientation) { :vertical }
    let(:other_direction) { :rtl }
    let(:other) { Arrays::WordSearch::Result.new }
    before do
      instance.add word, orientation: orientation, direction: direction
      if other.is_a?(Arrays::WordSearch::Result)
        other.add other_word, orientation: other_orientation, direction: other_direction
      end
    end

    subject! { instance == other }

    context 'when other has different values' do
      it { is_expected.to be_falsey }
    end

    context 'when other is from any other class' do
      let(:other) { '' }

      it { is_expected.to be_falsey }
    end

    context 'when other has the same words' do
      let(:other_word) { word }
      let(:other_orientation) { orientation }
      let(:other_direction) { direction }

      it { is_expected.to be_truthy }
    end

    context 'when other is a Hash' do
      let(:other) { instance.words }

      it 'compares the given Hash with the Result words' do
        is_expected.to be_truthy
      end
    end
  end
end

RSpec.describe Arrays::WordSearch::Search do
  let(:values) do
    [
      %w[T H G U O R],
      %w[O W T R E E],
      %w[R H O U O R],
      %w[O C O R T D],
      %w[C B T C E R],
      %w[K B T C O H]
    ]
  end
  let(:grid) { Arrays::WordSearch::Grid.new values }
  let(:instance) { Arrays::WordSearch::Search.new grid }

  describe '#find_all_words_from' do
    let(:file_path) { 'spec/fixtures/dict.txt' }
    subject! { instance.find_all_words_from file_path }
    let(:values) do
      [
        %w[T H G U O R],
        %w[O W T R E E],
        %w[R H O U O R],
        %w[E C O R T D],
        %w[C B T C E R],
        %w[K B T C O H]
      ]
    end

    it 'returns all words found on the given source' do
      is_expected.to eq(
        horizontal: {
          ltr: %w[OR OW RE REE TREE HO OR RHO OR COR ORT ER OH],
          rtl: %w[UGH OUGHT ROUGH ER WO TWO OH ROC RE REC HO]
        },
        vertical: {
          tb: %w[OR RE TO ORE REC TOR RECK TORE TO OOT TOO TOOT OE ER RE],
          bt: %w[ER ROT CERO TO OOT TOO TOOT CRU ET OE TO TOE ER RE]
        },
        diagonal: {
          ltr: %w[EH OR RE WO ORE TWO WORE],
          rtl: %w[ER HE OW HER ROW HERO]
        }
      )
    end
  end
end
