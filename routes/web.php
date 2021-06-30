<?php

use App\Http\Controllers\DoctorController;
use App\Http\Controllers\DoctorRefferalController;
use App\Http\Controllers\PacientController;
use App\Http\Controllers\ProcedureController;
use App\Http\Controllers\ProcedureRefferalController;
use App\Http\Controllers\SurveyController;
use App\Http\Controllers\SurveyRefferalController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::group(array('prefix' => 'refferals'), function() {
    Route::resource('survey', SurveyRefferalController::class);
    Route::resource('doctor', DoctorRefferalController::class);
    Route::resource('procedure', ProcedureRefferalController::class);
});

Route::group(array('prefix' => 'admin'), function() {
    Route::resource('doctor', DoctorController::class);
    Route::resource('survey', SurveyController::class);
    Route::resource('procedure', ProcedureController::class);
});

Route::resource('pacient', PacientController::class);

Route::get('/', function () {
    return view('welcome');
});