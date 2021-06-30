<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;

class Survey
{
    private string $name;
    private int    $specialty;

    public function __construct(string $name, int $specialty)
    {
        $this->name      = $name;
        $this->specialty = $specialty;
    }

    static public function all() : array {
        return DB::select('SELECT * FROM `survey`');
    }

    static public function one(int $id) : array {
        return DB::select('SELECT * FROM `survey` WHERE 1 survey.id = ?', array($id));
    }

    public function add() : bool {
        return DB::insert('INSERT INTO `survey`(`name`, `specialty_id`) VALUES (?, ?)', array($this->name, $this->specialty));
    }

    public function update(int $id) : bool {
        return DB::update('UPDATE `survey` SET `name`=?, `specialty_id`=? WHERE survey.id=?', array($this->fio, $this->birsday, $this->phone, $this->email, $this->pass, $this->doctor_id, $id));
    }

    static public function delete(int $id) : int {
        return DB::delete('DELETE FROM survey WHERE survey.id = ?', array($id));
    }
}
