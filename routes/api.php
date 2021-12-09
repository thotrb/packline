<?php

use App\Http\Controllers\FormController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('users/{username}', FormController::class.'@get');

Route::get('machines/{productionlineID}', FormController::class.'@getMachines');

Route::get('sites', FormController::class.'@getSites');

Route::get('machines/{productionlineID}', FormController::class.'@getMachines');

Route::get('speedLosses/{PO}/{productionLine}', FormController::class.'@get_speedLosses');

Route::get('pos/{shift}/{site}', FormController::class.'@getPOsFromShift');

Route::get('events/{PO}/{productionLine}', FormController::class.'@getEvents');

Route::get('unplannedDowntimeEvents/{productionLine}/{startYear}/{endYear}', FormController::class.'@getUnplannedDowntimeEvents');

Route::get('unplannedDowntimeMachineShutdownTypes/{productionLine}/{startYear}/{endYear}', FormController::class.'@getUnplannedDowntimeMachineShutdownTypes');

Route::get('summary/{productionName}/{downTimeType}', FormController::class.'@getDowntimeReasons');

Route::get('{productionName}/{downtimeType}/unplannedDowntime', FormController::class.'@get_unplannedDowntime_2');

Route::get('unplannedDowntime/unplannedDowntime/{machineName}', FormController::class.'@get_unplannedDowntime_Machine_Issue');

Route::get('worksiteID/{worksite}', FormController::class.'@getWorksiteID');

Route::get('productionlineID/{productionline}', FormController::class.'@getProductionlineID');

Route::get('productionlineID/{productionline}', FormController::class.'@getProductionlineID');

Route::get('allevents/{site}/{productionLine}/{beginningDate}/{endingDate}', FormController::class.'@getAllEventsPeriod');

Route::get('qualityLosses/{site}/{productionLine}/{beginningDate}/{endingDate}', FormController::class.'@getQualityLossesPeriod');

Route::get('allVolumes/{site}/{productionLine}/{beginningDate}/{endingDate}', FormController::class.'@getAllVolumes');

Route::get('assignation/{username}/{po}/{productionline}', FormController::class.'@isAssignationPossible');

Route::get('po/{po}', FormController::class.'@isPOPossible');

Route::get('netOP/{GMID}', FormController::class.'@getNetOP');

Route::get('performance/{PO}', FormController::class.'@getPerformanceForASite');

Route::post('assignation', FormController::class.'@createAssignement');

Route::post('PO',FormController::class.'@createPO');

/**
Route::post('storeRejection/{po}/{labelerCounter}/{weightBoxCounter}/{caperCounter}/{fillerCounter}/{labelerRejection}/{weightBoxRejection}/{caperRejection}/{fillerRejection}/{qualityControlCounter}/{qualityControlRejection}', FormController::class.'@storeRejection');
**/
Route::post('storeRejection', FormController::class.'@storeRejection');


Route::post('log/{username}/{password}', FormController::class.'@log');

Route::post('stopPO/{PO}/{availability}/{performance}/{quality}/{OLE}/{quantityProduced}/{totalDuration}', FormController::class.'@stopPO');

Route::post('unplannedEvent/changingFormat', FormController::class.'@saveUnplannedEvent_Changingformat');

Route::post('unplannedEvent/clientChanging', FormController::class.'@saveUnplannedEvent_Clientchanging');

Route::post('unplannedEvent/CIP', FormController::class.'@saveUnplannedEvent_CIP');

Route::post('unplannedEvent/unplannedDowntime', FormController::class.'@saveUnplannedEvent');

Route::post('plannedEvent', FormController::class.'@savePlannedEvent');

Route::post('speedLoss', FormController::class.'@saveSpeedLoss');






