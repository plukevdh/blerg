# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration

moment = require 'moment'

docpadConfig = {
  mixpanelToken: "4e4ef8a8ab371d4f3c0a05814a896f64"

  collections:
    posts: ->
      @getCollection("html").findAllLive({isPost:true},{date:-1})

  templateData:
    formatDate: (date) ->
      moment(date).format('L')

    getPreview: (doc) ->
      return unless doc.rendered
      paragraphs = doc.contentRenderedWithoutLayouts.split(/<p>/)
      output = paragraphs.slice(0, doc.preview+1).join("")
      output += "<a href='#{doc.url}' class='read-more'>Read More...</a>"


  plugins:
    rss:
      collection: 'posts'
}

# Export the DocPad Configuration
module.exports = docpadConfig