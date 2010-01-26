require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Puncher do
  describe 'initialize' do
    it 'should create a puncher' do
      @puncher = Puncher.new("echo 'boosh'", '.*')

      @puncher.should_not be_nil
    end
  end
end
