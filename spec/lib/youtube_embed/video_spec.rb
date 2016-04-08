require 'spec_helper'

describe YoutubeEmbed::Video do
  describe "#initialize" do
    subject { YoutubeEmbed::Video.new('', options) }

    context "if default options are applied" do
      let(:options) { {} }
      it { is_expected.not_to be_show_similar }
      it { is_expected.to be_show_title }
      it { is_expected.to be_allow_fullscreen }
      it { expect(subject.width).to eq 640 }
      it { expect(subject.height).to eq 360 }
    end

    context "if `show_similar` option is set to true" do
      let(:options) { {show_similar: true} }
      it { is_expected.to be_show_similar }
    end

    context "if `show_title` option is set to false" do
      let(:options) { {show_title: false} }
      it { is_expected.not_to be_show_title }
    end

    context "if `allow_fullscreen` option is set to false" do
      let(:options) { {allow_fullscreen: false} }
      it { is_expected.not_to be_allow_fullscreen }
    end

    context "if `height` options is set" do
      let(:options) { {height: 532} }
      it { expect(subject.height).to eq 532 }
    end

    context "if `width` options is set" do
      let(:options) { {width: 123} }
      it { expect(subject.width).to eq 123 }
    end
  end

  describe "#video_id" do
    subject { YoutubeEmbed::Video.new(video_url).video_id }

    context "for short url" do
      let(:video_url) { 'https://youtu.be/XD_e7T5WCqw' }
      it "returns right video id" do
        is_expected.to eq 'XD_e7T5WCqw'
      end
    end

    context "for long url" do
      let(:video_url) { 'https://www.youtube.com/watch?v=XD_e7T5WCqw' }
      it "returns right video id" do
        is_expected.to eq 'XD_e7T5WCqw'
      end
    end
  end

  describe "#embed_url" do
    let(:video) { YoutubeEmbed::Video.new('https://www.youtube.com/watch?v=XD_e7T5WCqw') }
    subject { video.embed_url }

    context "if `show_similar` option is true" do
      before{ allow(video).to receive(:show_title?).and_return(true) }
      before{ allow(video).to receive(:show_similar?).and_return(true) }
      it "doesn't add `rel` parameter" do
        is_expected.to eq 'https://www.youtube.com/embed/XD_e7T5WCqw'
      end
    end
    context "if `show_similar` option is false" do
      before{ allow(video).to receive(:show_title?).and_return(true) }
      before{ allow(video).to receive(:show_similar?).and_return(false) }
      it "adds `rel` get parameter set to 0" do
        is_expected.to eq 'https://www.youtube.com/embed/XD_e7T5WCqw?rel=0'
      end
    end
    context "if `show_title` option is true" do
      before{ allow(video).to receive(:show_similar?).and_return(true) }
      before{ allow(video).to receive(:show_title?).and_return(true) }
      it "doesn't add `showinfo` parameter" do
        is_expected.to eq 'https://www.youtube.com/embed/XD_e7T5WCqw'
      end
    end
    context "if `show_title` option is false" do
      before{ allow(video).to receive(:show_similar?).and_return(true) }
      before{ allow(video).to receive(:show_title?).and_return(false) }
      it "adds `showinfo` get parameter set to 0" do
        is_expected.to eq 'https://www.youtube.com/embed/XD_e7T5WCqw?showinfo=0'
      end
    end
    context "if both `show_title` and `show_similar` option are false" do
      before{ allow(video).to receive(:show_similar?).and_return(false) }
      before{ allow(video).to receive(:show_title?).and_return(false) }
      it "adds `showinfo` and `rel` get parameters set to 0" do
        is_expected.to eq 'https://www.youtube.com/embed/XD_e7T5WCqw?rel=0&amp;showinfo=0'
      end
    end
  end

  describe "#iframe" do
    let(:video) { YoutubeEmbed::Video.new('https://www.youtube.com/watch?v=XD_e7T5WCqw') }
    subject { video.iframe }

    before{ allow(video).to receive(:embed_url).and_return('https://embed') }

    it "generates html code for iframe" do
      is_expected.to eq  %(<iframe width="640" height="360" src="https://embed" frameborder="0" allowfullscreen></iframe>)
    end

    context 'if `allow_fullscreen` options is false' do
      before{ allow(video).to receive(:allow_fullscreen?).and_return(false) }
      it "generates html code for iframe with disabled fullscreen" do
        is_expected.to eq  %(<iframe width="640" height="360" src="https://embed" frameborder="0"></iframe>)
      end
    end

    context 'if `height` and `width` options are set' do
      before{ allow(video).to receive(:height).and_return(567) }
      before{ allow(video).to receive(:width).and_return(981) }
      it "generates html code for iframe with given width and height" do
        is_expected.to eq  %(<iframe width="981" height="567" src="https://embed" frameborder="0" allowfullscreen></iframe>)
      end
    end
  end
end
