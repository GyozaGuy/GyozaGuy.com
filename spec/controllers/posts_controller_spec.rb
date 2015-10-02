require 'spec_helper'

describe PostsController do
  render_views
  describe 'index' do
    before do
      Post.create!(title: 'Test Post 1')
      Post.create!(title: 'Test Post 2')
      Post.create!(title: 'Test Post 3')
      Post.create!(title: 'Test Post 4')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_title
      ->(object) { object['title'] }
    end

    context 'when the search finds results' do
      let(:keywords) { 'test' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return four results' do
        expect(results.size).to eq(4)
      end
      it 'should include "Test Post 1"' do
        expect(results.map(&extract_title)).to include('Test Post 1')
      end
      it 'should include "Test Post 2"' do
        expect(results.map(&extract_title)).to include('Test Post 2')
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end
