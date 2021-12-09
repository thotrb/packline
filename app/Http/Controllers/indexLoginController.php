<?php


namespace App\Http\Controllers;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class indexLoginController extends Controller
{


    public function index()
    {
        session_start();
        return view('loginMenu');
    }

    public function loginPage(){
        $_SESSION['connectionType'] = request('typeLogin');
        return view('login');
    }

    public function get(Request $request)
    {

    }
}
