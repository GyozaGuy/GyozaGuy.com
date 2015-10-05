require 'spec_helper'

describe PostsController do
  render_views
  describe 'index' do
    before do
      Post.create!(id: 1, title: 'Test Post 1')
      Post.create!(id: 2, title: 'Test Post 2')
      Post.create!(id: 3, title: 'Test Post 3')
      Post.create!(id: 4, title: 'Test Post 4')

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

  describe 'show' do
    before do
      xhr :get, :show, format: :json, id: post_id
    end

    subject(:results) { JSON.parse(response.body) }

    context 'when the post exists' do
      let(:post) {
        Post.create!(title: 'Test Post 1', content: 'This is a test of the emergency alert system.')
      }
      let(:post_id) { post.id }

      it { expect(response.status).to eq(200) }
      it { expect(results['id']).to eq(post.id) }
      it { expect(results['title']).to eq(post.title) }
      it { expect(results['content']).to eq(post.content) }
    end

    context "when the post doesn't exit" do
      let(:post_id) { -9999 }
      it { expect(response.status).to eq(404) }
    end
  end
end
