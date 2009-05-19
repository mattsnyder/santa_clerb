require 'lib/secret_santa_engine'

Spec::Matchers.define(:give_a_gift) do |matches|
  match do |participant|
    matches.any? {|match| match[:santa] == participant}
  end

  failure_message_for_should do |participant|
    msg = "#{participant} is not giving anyone anything!"
  end
end

Spec::Matchers.define(:receive_a_gift) do |matches|
  match do |participant|
    matches.any? {|match| match[:recipient] == participant}
  end

  failure_message_for_should do |participant|
    msg = "#{participant} is not receiving anything!"
  end
end

Spec::Matchers.define(:not_gift_themselves) do |matches|
  match do |participant|
    matches.all? {|match| match != {:santa => participant, :recipient => participant} }
  end

  failure_message_for_should do |participant|
    msg = "#{participant} is gifting themselves!"
  end
end

describe SecretSantaEngine do
  before(:each) do
    @engine = SecretSantaEngine.new
    @people = ["Han Solo", "Luke Skywalker"]
  end

  it "new instance should not be nil" do
     @engine.nil?.should == false
  end
  
  it "should return empty list if not enough participants" do
     @engine.shuffle.length.should == 0
  end
  
  it "should take a player for the list" do
    @engine.add(["Luke Skywalker"])
    @engine.shuffle.should be_empty
  end
  
  context "basic rules for 2 participants" do
    before(:each) do
      @engine.add(@people)
      @matches = @engine.shuffle
    end
  
    it "each participant should give a gift" do
      @people.first.should give_a_gift(@matches) 
      @people[1].should give_a_gift(@matches)
    end
  
    it "each participant should receive a gift" do
      @people.first.should receive_a_gift(@matches)
      @people[1].should receive_a_gift(@matches)
    end
    
    it "each person should not give themselves a gift" do
      @people.first.should not_gift_themselves(@matches)
      @people[1].should not_gift_themselves(@matches)
    end
  end
  
end