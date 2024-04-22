<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Word;

class WordController extends Controller
{
    public function index()
    {
        $words = Word::all();
        return response()->json($words);
    }

    public function store(Request $request)
    {
        $request->validate([
            'text' => 'required|string|max:255',
        ]);

        $word = Word::create([
            'text' => $request->text,
        ]);

        return response()->json($word, 201);
    }
}

