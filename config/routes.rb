ActionController::Routing::Routes.draw do |map|
  map.problems_by_category 'problems/category/:category',
    :controller => 'problems', :action => 'index'
  map.problems_by_tag 'problems/tag/:tag',
    :controller => 'problems', :action => 'index'
  map.users_by_language 'users/language/:name',
    :controller => 'users', :action => 'index'

  map.resources :answers
  map.resources :problems, :collection => {:wanted => :get, :unsolved => :get}
  map.resource :account, :only => [:show, :edit, :update, :destroy]
  map.resource :user_session, :only => [:new, :create, :destroy]

  map.root :controller => 'top'
  map.root_for_yahoo 'index.html', :controller => 'top'

  map.with_options :controller => 'about',
                   :name_prefix => 'about_',
                   :path_prefix => 'about' do |page|
    page.category 'category', :action => 'category'
    page.license  'license',  :action => 'license'
    page.markdown 'markdown', :action => 'markdown'
    page.hint     'hint',     :action => 'hint'
  end

  map.with_options :controller => 'users' do |page|
    page.users 'users',  :action => 'index'
    page.user  ':login', :action => 'show'
  end
end
