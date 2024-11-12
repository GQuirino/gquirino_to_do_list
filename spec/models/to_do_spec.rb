require 'rails_helper'

RSpec.describe ToDo, type: :model do
  let(:status) { :pending }
  let(:title) { "New Title" }
  let(:description) { "New Description" }
  let(:to_do_item) { described_class.new(title:, status:, description:) }

  describe "validations" do
    context "#status" do
      context "with valid status" do
        subject { to_do_item }

        it "returns true" do
          expect(subject).to be_valid
        end

        it "is valid with a status of 'pending'" do
          status = :pending
          expect(subject).to be_valid
        end

        it "is valid with a status of 'complete'" do
          status = :complete
          expect(subject).to be_valid
        end
      end

      context "with invalid status" do
        it "returns false" do
          status = :invalid_status
          expect(subject).not_to be_valid
        end

        it "is not valid without a status" do
          status = nil
          expect(subject).not_to be_valid
          expect(subject.errors[:status]).to include("can't be blank")
        end
      end
    end

    context "#title" do
      context "with valid title" do
        subject { to_do_item }

        it "returns true" do
          expect(subject).to be_valid
        end
      end

      context "with invalid title" do
        it "is not valid without a title" do
          title = nil
          expect(subject).not_to be_valid
          expect(subject.errors[:title]).to include("can't be blank")
        end
      end
    end

    context "#description" do
      context "with valid description" do
        subject { to_do_item }

        it "returns true" do
          expect(subject).to be_valid
        end
      end

      context "with invalid description" do
        it "is not valid without a description" do
          description = nil
          expect(subject).not_to be_valid
          expect(subject.errors[:description]).to include("can't be blank")
        end
      end
    end
  end
end
