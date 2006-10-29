Getting Started
===============

You should first use the "Setup Blogs" command to identify any blogs you wish to post to. This command will load a file for editing. Within this file, you simply specify a blog name and the XMLRPC URL for it. For example:

    My MT Blog          http://myusername@mydomain.com/mt/mt-xmlrpc.cgi#1
    My WordPress Blog   http://myusername@mydomain.com/blog/xmlrpc.php
    My Typo Blog        http://myusername@mydomain.com/backend/xmlrpc

After you've configured for your blog(s), try the "Fetch Post" command to retrieve an existing post for editing. This is the easiest way to confirm that your configuration is correct. You will be prompted for your password upon initially connecting to your blog. Once you have that working, you should have no problem publishing a new post.

To create a new blog entry, create a new document from one of the Blogging templates:

* Blog Post (Markdown)
* Blog Post (Textile)
* Blog Post (HTML)
* Blog Post (Text)

Each of these will give you a basic heading section followed with the text of the post itself. Additional headers are defined as snippets within this bundle. Once you've composed your post, use the "Post to Blog" command to publish it. Upon a successful post (and assuming you elected to publish the post, instead of setting it to a draft state), your browser will open to the published page. The document window you were working in will also be refreshed with the post as retrieved from your blog (which will add other missing headers, such as the post ID).

Feel free to customize these templates to suit your preferences.

Headers
=======

To specify all the relevant metadata along with your post, add one of the following items to the top of the document:

* Title - The title for your entry.
* Post - The ID of the blog entry (this is meant to be assigned by the server; you shouldn't have to enter this yourself).
* Date - The date of the post. Omit this header to post with the current time.
* Category - One or more headers to specify the categories for the entry.
* Ping - One or more TrackBack URLs you wish to ping.
* Keywords - A list of keywords to associate with the entry.
* Tags - A list of tags to assign to the entry.
* Pings - "On" or "Off"; used to control whether the entry accepts TrackBacks.
* Comments - "On" or "Off"; used to control whether the entry accepts comments.
* Format - Typically server assigned; the format of the template you're using should control this.
* Blog - An XMLRPC endpoint URL or blog identifier (from your blog accounts file).

Header lines are written with the heading keyword followed with a colon (":") and then the value for the keyword follows.

    Title: Title of the post

Certain headers may be repeated, allowing you to assign your post to multiple categories (with the "Category" header) or to ping multiple blogs (with the "Ping" header).

All of these headers are optional. If you don't specify any of them, they will typically be assigned a default value by your blog software. The "Title" field is the only thing that will be requested if it is omitted. If you try to post an entry without a title, you will be asked for a title. However when prompted, you may still leave it blank if you wish.

The "Date" header must be specified with this format: YYYY-MM-DD HH:MM:SS. You may omit the time, but it will be replaced with 12 AM if you do so. Leaving the date header out altogether will cause your entry to be posted with the current time.

Your blog software may not support some of these headers. I recommend that you issue a Fetch command to retrieve an existing post and take note of the headers returned with the post. That will give you an indication of which headers are supported for new posts.

Commands
========

* **Post to Blog**: Takes a new or edited post and publishes it to your configured blog.
* **Fetch Post**: Selects the last available posts (up to 20) and lets you choose one for editing. This will create a new document locally that you can edit and then republish using the Post to Blog command.
* **View Online Version**: For a published post (one with a Post ID within the document), this command will take you to the permalink for that post.
* **Setup Blogs**: Loads the blog accounts file for editing the list of blogs that you want to publish to.

Image Uploads
=============

It is possible to upload an image to your blog endpoint by dragging it into the document. After successful upload the URL of the image will be inserted.

By default you will be asked for the description of the image (used as argument for the `alt` attribute) and a “safe” file name will be derived from this description (i.e. lowercased using only alphanumeric characters and no spaces).

If you instead wish to provide the actual file name under which the image should be uploaded then you can hold down option (&#x2325;) when dragging it into your document.

Environment Variables
=====================

The following settings are available, but optional. They can either be specified in TextMate's global Shell Variables or within a specific project.

* `TM_BLOG_ENDPOINT`: You may either specify a named blog endpoint (as configured with the "Setup Blogs" command) or an endpoint URL. This value can be overriden by a "Blog" header within a post. If this is unset **and** your document doesn't have a "Blog" header, you will be prompted for which blog to use.
* `TM_BLOG_FORMAT`: Your preferred formatting choice (default will derive from current blog template selected).
* `TM_BLOG_MODE`: 'mt' and 'wp' are valid settings for this. Influences the posting API to be as compatible as possible with Movable Type, TypePad, Blogger, Typo and WordPress variants of the metaWeblog API (default will derive from endpoint URL, or will default to 'mt').
* `TM_HTTP_PROXY`: If you are behind a proxy set it to `host:port` of the proxy.


Troubleshooting
===============

* If you change your blog password, you will need to also change your local password. The password is stored in your KeyChain, so you'll have to search for it and update it or delete the Keychain record to be prompted to reauthenticate.

Credits
=======

This bundle is maintained by [Brad Choate][1].

[1]: http://bradchoate.com/
