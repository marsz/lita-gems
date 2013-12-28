require "spec_helper"

describe Lita::Handlers::Gems, :lita_handler => true do
  it "#info" do
    send_command("gem rails")
    expect(replies.last).to match("rails")
  end

  context "#search" do

    it "no keyword" do
      send_command("gem q")
      expect(replies.size).to eq(0)
    end

    it "not found" do
      send_command("gem q rails girls")
      expect(replies.first).to match("Not found")
    end

    it "success with space" do
      send_command("gem q simple form")
      expect(replies.first).to match("rubygems.org")
      expect(replies.first).to match("%20")
    end

  end
end
