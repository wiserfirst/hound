require "rails_helper"

describe AnalyticsHelper do
  describe "#analytics?" do
    context "when SEGMENT_KEY is present" do
      it "returns true" do
        ENV["SEGMENT_KEY"] = "anything"

        expect(analytics?).to be_truthy

        ENV["SEGMENT_KEY"] = nil
      end
    end

    context "when SEGMENT_KEY is not present" do
      it "returns false" do
        ENV["SEGMENT_KEY"] = nil

        expect(analytics?).to be_falsy
      end
    end

    describe "identify_hash" do
      it "will include user data" do
        user = create(:user)
        active_repo = create(:repo, users: [user], active: true)
        create(:repo, users: [user], active: false)
        identify_hash = identify_hash(user)

        expect(user.repos.count).to eq(2)
        expect(identify_hash[:created]).to eq(user.created_at)
        expect(identify_hash[:email]).to eq(user.email_address)
        expect(identify_hash[:username]).to eq(user.github_username)
        expect(identify_hash[:user_id]).to eq(user.id)
        expect(identify_hash[:active_repo_ids]).to eq([active_repo.id])
      end
    end
  end
end
