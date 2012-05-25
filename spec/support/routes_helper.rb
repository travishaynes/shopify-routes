def find_route(name)
  @router.routes.find {|r| r.name == name.to_s }
end

def redirect_for(resource, id = nil)
  route   = find_route(resource)
  params  = { :shop => @domain }
  params[:id] = id unless id.nil?
  route.app.path(params, nil)
end

def path_for(resource, id = nil)
  path = "https://#{@domain}/admin/#{resource.to_s}"
  path += "/#{id}" unless id.nil?
  path
end
