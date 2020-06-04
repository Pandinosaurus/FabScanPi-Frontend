name = 'fabscan.services.FSScanService'

angular.module(name, []).factory(name, [
  '$log',
  '$rootScope'
  'fabscan.services.FSEnumService',
  'fabscan.services.FSMessageHandlerService'
  ($log,$rootScope, FSEnumService, FSMessageHandlerService) ->
    service = {}

    service.state = FSEnumService.states.IDLE
    service.scanId = null
    service.startTime = null

    service.initStartTime = ->
      service.startTime = Date.now()

    service.setStartTime = (time) ->
      service.startTime = time

    service.getStartTime = ->
      service.startTime

    service.getScanId = () ->
      service.scanId

    service.setScanId = (id) ->
      service.scanId = id

    service.startScan = (options) ->

      service.state = FSEnumService.states.SCANNING
      service.setScanId(null)
      service.initStartTime()
      # FIXME: ( or find better solution )
      # needed to be done here, cause raspberry has not a real time clock,
      # when no internet connection is availabale on the fabscan the time
      # will be set (default) to 1970, this leads to a wrong calculation...

      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.START
          startTime: service.getStartTime()


      FSMessageHandlerService.sendData(message)
      $rootScope.$broadcast(FSEnumService.commands.START)

    service.updateSettings = (settings) ->

      message = {}
      message =
      event: FSEnumService.events.COMMAND
      data:
        command: FSEnumService.commands.UPDATE_SETTINGS
        settings: settings

      FSMessageHandlerService.sendData(message)

    service.startSettings = (settings) ->
      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.SCAN
          #settings: settings

      FSMessageHandlerService.sendData(message)

    service.upgradeServer = () ->
      $log.debug("Upgrade Server called.")
      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.UPGRADE_SERVER

      FSMessageHandlerService.sendData(message)

    service.restartServer = () ->
      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.RESTART_SERVER

      FSMessageHandlerService.sendData(message)

    service.stopScan = () ->
      service.setScanId(null)
      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.STOP

      FSMessageHandlerService.sendData(message)
      $rootScope.$broadcast(FSEnumService.commands.STOP)

    service.startCalibration = () ->
      message = {}
      service.initStartTime()

      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.CALIBRATE
          startTime: service.getStartTime()

      FSMessageHandlerService.sendData(message)
      $rootScope.$broadcast(FSEnumService.commands.CALIBRATE)

    service.runMeshing = (scan_id, filter, format, file) ->

      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.MESHING
          scan_id: scan_id
          file: file
          format: format
          filter: filter

      FSMessageHandlerService.sendData(message)


    service.exitScan = () ->

      message = {}
      message =
        event: FSEnumService.events.COMMAND
        data:
          command: FSEnumService.commands.STOP

      FSMessageHandlerService.sendData(message)

    service.getScannerState = ()->
      service.state


    service.setScannerState = (state) ->
      service.state = state

    service.getSettings = () ->
       message = {}
       message =
        event: FSEnumService.events.COMMAND
        #data:
          #command: FSEnumService.commands.GET_SETTINGS


    service

])
