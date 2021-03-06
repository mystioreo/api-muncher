require "test_helper"

describe RecipesController do

  describe 'home' do
    it 'succeeds' do
      get root_path

      must_respond_with :success
    end
  end
  describe 'index' do
    it 'succeeds with valid search keyword' do
      VCR.use_cassette('recipe_search') do
        get recipes_path, params: {keyword: 'tofu'}

        must_respond_with :success
      end
    end

    it 'succeeds with valid search keyword and health label checkboxes' do
      VCR.use_cassette('recipe_search') do
        get recipes_path, params: {keyword: 'tofu', 'vegan' => '1', 'peanut-free' => '1', 'tree-nut-free' => '1'}

        must_respond_with :success
      end
    end

    it 'responds with bad_request with invalid search keyword' do
      VCR.use_cassette('recipe_search') do
        get recipes_path, params: {keyword: 'qmwmemrmtmmtmy'}

        must_respond_with :bad_request
      end
    end

  end

  describe 'show' do
    it 'succeeds with valid id' do
      VCR.use_cassette('show_recipe') do
        get recipe_path("5c16802dd815e76ce94487b567073877")

        must_respond_with :success
      end
    end

    it 'responds with bad_request with invalid id' do
      VCR.use_cassette('show_recipe') do
        get recipe_path("absolutegarbage")

        must_respond_with :bad_request
      end
    end
  end
end
