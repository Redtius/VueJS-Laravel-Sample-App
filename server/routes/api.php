<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\WordController;

Route::get('/words', [WordController::class, 'index']);
Route::post('/words', [WordController::class, 'store']);
