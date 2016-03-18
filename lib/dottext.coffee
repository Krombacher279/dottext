DottextView = require './dottext-view'
{CompositeDisposable} = require 'atom'

module.exports = Dottext =
  dottextView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @dottextView = new DottextView(state.dottextViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @dottextView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'dottext:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dottextView.destroy()

  serialize: ->
    dottextViewState: @dottextView.serialize()

  toggle: ->
    console.log 'Dottext was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
