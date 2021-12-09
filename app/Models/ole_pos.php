<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ole_pos extends Model
{

    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['number', 'GMIDCode', 'productionline_name'];
}
