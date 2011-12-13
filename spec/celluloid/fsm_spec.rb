require 'spec_helper'

describe Celluloid::FSM do
  before :all do
    class TestMachine
      include Celluloid::FSM

      def initialize
        @fired = false
      end

      state :callbacked do
        @fired = true
      end

      state :done

      def fired?; @fired end
    end
  end

  let(:subject) { TestMachine.new }

  it "starts in the default state" do
    subject.state == TestMachine.default_state
  end

  it "transitions between states" do
    subject.state.should_not == :done
    subject.transition :done
    subject.state.should == :done
  end

  it "fires callbacks for states" do
    subject.should_not be_fired
    subject.transition :callbacked
    subject.should be_fired
  end
end
