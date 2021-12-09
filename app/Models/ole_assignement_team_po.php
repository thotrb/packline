<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ole_assignement_team_po extends Model
{

    use HasFactory;
    protected $fillable = ['username', 'productionline', 'po', 'shift', 'worksite'];

}
