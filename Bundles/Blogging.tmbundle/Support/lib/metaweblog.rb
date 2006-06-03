require 'xmlrpc/client'

class MetaWeblogClient < XMLRPC::Client
	def get_post(post_id, username, password)
		return call("metaWeblog.getPost", post_id, username, password)
	end
	def edit_post(post_id, username, password, post, publish)
		return call("metaWeblog.editPost", post_id, username, password, post, publish)
	end
	def new_post(blog_id, username, password, post, publish)
		return call("metaWeblog.newPost", blog_id, username, password, post, publish)
	end
	def get_recent_posts(blog_id, username, password, number)
		return call("metaWeblog.getRecentPosts", blog_id, username, password, number)
	end

	# These methods are properCased to match the XMLRPC method names.
	def getPost(post_id, username, password)
		return call("metaWeblog.getPost", post_id, username, password)
	end
	def editPost(post_id, username, password, post, publish)
		return call("metaWeblog.editPost", post_id, username, password, post, publish)
	end
	def newPost(blog_id, username, password, post, publish)
		return call("metaWeblog.newPost", blog_id, username, password, post, publish)
	end
	def getRecentPosts(blog_id, username, password, number)
		return call("metaWeblog.getRecentPosts", blog_id, username, password, number)
	end
end
