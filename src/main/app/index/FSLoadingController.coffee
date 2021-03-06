name = "fabscan.controller.FSLoadingController"

angular.module(name, []).controller(name, [
  '$log',
  '$scope',
  '$rootScope',
  'fabscan.services.FSScanService',
  'fabscan.services.FSEnumService'
  'common.services.Configuration',
  ($log, $scope, $rootScope, FSScanService, FSEnum, Configuration) ->

    $scope.loadPointCloud = (pointcloud, id) ->
        $scope.setScanIsLoading(true)
        $scope.setScanIsComplete(false)
        $scope.toggleLoadDialog()
        FSScanService.setScanId(id)
        $scope.setScanLoaded(false)

        toastr.info("Loading scanned Pointcloud "+id)
        $scope.loadPLY( pointcloud)

    $scope.loadMesh = (mesh, id) ->
        return




])