module CompaniesHelper
  def script_publish_path company
    "<script src='http://localhost:3000/publish/#{company.apikey}.js' type='text/javascript'></script>" +
    ""
  end
  
  def test 
    "psocket.logout()"
    "psocket.login('username')"
  end
end
