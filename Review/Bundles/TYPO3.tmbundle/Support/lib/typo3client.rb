require 'xmlrpc/client'

class Typo3Client < XMLRPC::Client
  
  # all supported methods by the Typo3 xmlrpc server
  
  def get_list(site_id, username, password)
    call("vfs.getList", "#{site_id}", "#{username}", "#{password}")
  end
  def get_constants(site_id, username, password, post, publish)
    call("vfs.getConstants", "#{site_id}", "#{username}", "#{password}")
  end
  def get_setup(site_id, username, password, post, publish)
    call("vfs.getSetup", "#{site_id}", "#{username}", "#{password}")
  end
  def put_constants(site_id, username, password, data)
    call("vfs.putConstants", "#{site_id}", "#{username}", "#{password}", data)
  end
  def put_setup(site_id, username, password, data)
    call("vfs.putSetup", "#{site_id}", "#{username}", "#{password}", data)
  end

end
