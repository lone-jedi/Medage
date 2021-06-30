<?php

namespace App\Models;

use Illuminate\Support\Facades\DB;

class Employee
{
    public const DOCTOR = 1;

    private string $fio;
    private string $phone;
    private string $email;
    private string $pass;
    private int    $specialty;

    public function __construct(string $fio, string $phone, string $email, string $pass, int $specialty)
    {
        $this->fio        = $fio;
        $this->phone      = $phone;
        $this->email      = $email;
        $this->pass       = $pass;
        $this->specialty  = $specialty;
    }

    static public function all() : array {
        return DB::select('SELECT * FROM `personal`');
    }

    static public function allSpec(int $specialty) : array {
        return DB::select('SELECT * FROM `personal` WHERE personal.specialty_id = ?', array($specialty));
    }

    static public function one(int $id) : array {
        return DB::select('SELECT * FROM `personal` WHERE personal.id = ?', array($id));
    }

    public function add() : bool {
        return DB::insert('INSERT INTO `personal` (personal.fio, personal.phone, personal.email, personal.pass, personal.specialty_id) VALUES (?, ?, ?, ?, ?)', array($this->fio, $this->phone, $this->email, $this->pass, $this->specialty));
    }

    public function update(int $id) : bool {
        return DB::update('UPDATE `personal` SET personal.fio = ?, personal.phone = ?, personal.email = ?, personal.pass = ?, personal.specialty_id = ? WHERE personal.id = ?', array($this->fio, $this->phone, $this->email, $this->pass, $this->specialty, $id));
    }

    static public function delete(int $id) : int {
        return DB::delete('DELETE FROM personal WHERE personal.id = ?', array($id));
    }
}
