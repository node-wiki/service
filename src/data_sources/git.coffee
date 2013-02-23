async = require 'async'
git = require('nodegit')

base = require './base'

# TODO: Testing for this file

class GitDataSource extends base.DataSource
  ### A data source which is backed by git repositories.
  
  A data source which is backed by git repositories. It supports the following
  meta attributes:

  message: A message describing why an action that has been invoked.

  ###

  createRepository: (name, callback) ->
    repo = new git.raw.Repo
    repo.init name, true, callback

  openRepository: (name, callback) ->
    git.repo name, callback

  # TODO: Get filename from git URL.
  getRepositoryFileName: -> @context.sourcePath

  retrieve: (identifier, meta, resultCallback) ->
    repo = null
    self = @

    async.waterfall [
      (callback) ->
        repo = self.openRepository self.getRepositoryFileName(), callback

      , (err, callback) ->
        repo.branch 'master', callback

      , (err, branch, callback) ->

        # async.js tries to transparently handle errors, which causes
        # us to have to call our callback manually in this case since
        # nodegit doesn't provide an err argument here.

        branch.tree().entry identifier, (entry) ->
          callback 0, entry.content

    ], (err, content) -> resultCallback err, content

  update: (identifier, meta) ->

  remove: (identifier, meta) ->

@DataSource = GitDataSource
