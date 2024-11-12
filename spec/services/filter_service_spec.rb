require 'rails_helper'

RSpec.describe FilterService do
  let!(:to_do_pending) { ToDo.create!(title: "Item 1", status: 'pending', description: 'Description') }
  let!(:to_do_complete) { ToDo.create!(title: "Item 2", status: 'completed', description: 'Description') }
  let(:scope) { ToDo.all }
  let(:filter_by) { nil }

  describe "#call" do
    context "when filter_by is null" do
      subject { described_class.new(scope, filter_by).call }

      it "returns the scope" do
        expect(subject).to be_an(ActiveRecord::Relation)
        expect(subject.size).to eq 2
        expect(subject).to include(to_do_pending)
        expect(subject).to include(to_do_complete)
      end
    end

    context "when filter_by is valid" do
      context "when is 'pending'" do
        filter_by = 'pending'
        subject { described_class.new(scope, filter_by).call }

        it "returns the items with pending status" do
          expect(subject.map(&:pending?)).to all(be(true))
          expect(subject.size).to eq 1
          expect(subject).to include(to_do_pending)
          expect(subject).to_not include(to_do_complete)
        end
      end

      context "when is 'completed'" do
        filter_by = 'completed'
        subject { described_class.new(scope, filter_by).call }

        it "returns the items with completed status" do
          expect(subject.map(&:completed?)).to all(be(true))
          expect(subject.size).to eq 1
          expect(subject).to include(to_do_complete)
          expect(subject).to_not include(to_do_pending)
        end
      end
    end
  end
end
