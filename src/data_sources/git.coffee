git = require('nodegit').raw
base = require './base'

class GitDataSource extends base.DataSource
  ### A data source which is backed by git repositories.
  
  A data source which is backed by git repositories. It supports the following
  meta attributes:

  message: A message describing why an action that has been invoked.

  ###

  createRepository: (name, callback) ->
    repo = new git.Repo

    repo.init name, true, callback

  retrieve: (identifier, meta) ->

  update: (identifier, meta) ->

  delete: (identifier, meta) ->

@DataSource = GitDataSource
