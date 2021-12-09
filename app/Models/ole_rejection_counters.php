<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ole_rejection_counters extends Model
{

    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['po', 'fillerCounter', 'caperCounter', 'labelerCounter', 'weightBoxCounter', 'fillerRejection',
        'caperRejection', 'labelerRejection', 'weightBoxRejection', 'qualityControlCounter', 'qualityControlRejection'];
}
