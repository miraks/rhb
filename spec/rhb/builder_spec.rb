require 'spec_helper'

describe Rhb::Builder do
  let(:builder) { Rhb::Builder.new }

  subject { builder.to_html }

  describe "content" do
    it "accepts it as a string" do
      builder.div 'content'
      should eq '<div>content</div>'
    end

    it "accepts it as a block" do
      builder.section do
        div 'content 1'
        div 'content 2'
      end
      should eq <<-HTML.strip
        <section><div>content 1</div><div>content 2</div></section>
      HTML
    end
  end

  describe "attributes" do
    it "accepts it as hash" do
      builder.a 'content', href: 'link', class: 'class'
      should eq '<a href="link" class="class">content</a>'
    end

    it "accepts nested hash" do
      builder.a 'content', href: 'link', data: { link: 'link' }
      should eq '<a href="link" data-link="link">content</a>'
    end

    it "accepts it as first argument instead content" do
      builder.a href: 'link', class: 'class'
      should eq '<a href="link" class="class"></a>'
    end
  end

  describe "#doctype" do
    it "adds doctype" do
      builder.doctype
      should eq '<!DOCTYPE html>'
    end
  end

  context "void element" do
    it "is not close it" do
      builder.link
      should eq '<link>'
    end

    it "ignores content" do
      builder.link 'content'
      should eq '<link>'
    end
  end

  context "tags" do
    it "processes 'p' inside block" do
      builder.div do
        p 'paragraph 1'
        p 'paragraph 2'
      end
      should eq <<-HTML.strip
        <div><p>paragraph 1</p><p>paragraph 2</p></div>
      HTML
    end
  end
end
