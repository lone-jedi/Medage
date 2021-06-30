<?php

namespace App\Models;

use Illuminate\Support\Facades\Date;
use Illuminate\Support\Facades\DB;

class Pacient
{
    private string $fio;
    private Date   $birsday;
    private string $phone;
    private string $email;
    private string $pass;
    private int    $doctor_id;

    public function __construct(string $fio, Date $birsday, string $phone, string $email, string $pass, int $doctor_id)
    {
        $this->fio       = $fio;
        $this->birsday   = $birsday;
        $this->phone     = $phone;
        $this->email     = $email;
        $this->pass      = $pass;
        $this->doctor_id = $doctor_id;
    }

    static public function all() : array {
        return DB::select('SELECT * FROM `pacients`');
    }

    static public function one(int $id) : array {
        return DB::select('SELECT * FROM `pacients` WHERE 1 pacients.id = ?', array($id));
    }

    public function add() : bool {
        return DB::insert('INSERT INTO `pacients`(`fio`, `date_birsday`, `phone`, `email`, `pass`, `doctor_id`) VALUES (?, ?, ?, ?, ?, ?)', array($this->fio, $this->birsday, $this->phone, $this->email, $this->pass, $this->doctor_id));
    }

    public function update(int $id) : bool {
        return DB::update('UPDATE `pacients` SET `fio`=?,`date_birsday`=?,`phone`=?,`email`=?,`pass`=?,`doctor_id`=? WHERE pacients.id=?', array($this->fio, $this->birsday, $this->phone, $this->email, $this->pass, $this->doctor_id, $id));
    }

    static public function delete(int $id) : int {
        return DB::delete('DELETE FROM pacients WHERE pacients.id = ?', array($id));
    }
}
