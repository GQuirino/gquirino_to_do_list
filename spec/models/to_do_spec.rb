require 'rails_helper'

RSpec.describe ToDo, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe "scopes" do
    let!(:to_do_pending) { ToDo.create!(title: 'Item 1', status: 'pending', description: 'New Item to do') }
    let!(:to_do_completed) { ToDo.create!(title: 'Item 2', status: 'completed', description: 'New Item to do') }

    context "pending" do
      subject { described_class.pending }

      it "returns pending items" do
        expect(subject.size).to eq 1
        is_expected.to include(to_do_pending)
      end

      it "doe not returns completed items" do
        expect(subject.size).to eq 1
        is_expected.to_not include(to_do_completed)
      end
    end

    context "completed" do
      subject { described_class.completed }

      it "returns completed items" do
        expect(subject.size).to eq 1
        is_expected.to include(to_do_completed)
      end

      it "doe not returns pending items" do
        expect(subject.size).to eq 1
        is_expected.to_not include(to_do_pending)
      end
    end

    context "default_scope" do
      subject { described_class.all }

      it "returns items in expected order" do
        expect(subject.size).to eq 2
        is_expected.to eq([ to_do_pending, to_do_completed ])
      end
    end
  end
end
