require "minitest/autorun"
require "minitest/spec"

$:.unshift(File.dirname(__FILE__) + "/../lib")
require "pluggable_source"

describe "A class with PluggableSource mixed in" do
  before do
    @blog_class = Class.new do
      include PluggableSource

      define_pluggable_source :new_posts, 
        :database => lambda {|attrs| :stub_from_database },
        :default => lambda {|attrs| :stub_from_flat_file }

      define_pluggable_source :logger do
        :stub_logger_instance
      end

      def add_post(post_attrs)
        using_source(:new_posts).call(post_attrs)
      end

      def logger
        using_source(:logger).call
      end
    end
  end

  it "uses the block by default" do
    blog = @blog_class.new
    assert_equal :stub_logger_instance, blog.logger
  end

  it "uses the choice named default by default" do
    blog = @blog_class.new
    assert_equal :stub_from_flat_file, blog.add_post({:title => "Foo"})
  end

  it "allows setting a source using a known symbol" do
    blog = @blog_class.new.tap do |b|
      b.set_source!(:new_posts, :database)
    end
    assert_equal :stub_from_database, blog.add_post({:title => "Foo"})
  end

  it "allows setting a source using a block" do
    blog = @blog_class.new.tap do |b|
      b.set_source!(:new_posts) {|attrs| :stub_from_block}
    end

    assert_equal :stub_from_block, blog.add_post({:title => "Foo"})
  end

  it "raises an error if the source can't be found and no block is given" do
    assert_raises ArgumentError do
      blog = @blog_class.new.tap do |b|
        b.set_source!(:new_posts, :not_valid)
      end
    end
  end
end
