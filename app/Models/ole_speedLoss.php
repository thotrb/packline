<?php


namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class ole_speedLoss extends Model
{

    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['OLE', 'productionline', 'duration', 'comment', 'reason'];


}
