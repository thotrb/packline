<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class ole_planned_events extends Model
{
    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['OLE', 'productionline', 'predicted_duration', 'reason', 'duration', 'comment'];

}
