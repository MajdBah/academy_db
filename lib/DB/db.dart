// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future _onConfigure(sql.Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> createTables(sql.Database database) async {
    // Department Table
    await database.execute("""CREATE TABLE Department(
    department_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    department_name varchar(255) NOT NULL
    )
      """);

    // Employee Table
    await database.execute("""CREATE TABLE Employee(
    employee_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    employee_name varchar(255) NOT NULL,
    phone_number char(10),
    job_title TEXT varchar(255) NOT NULL,
    city varchar(255),
    state varchar(25),
    zip_code varchar(255),
    department_id,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
    )
      """);

    // Student Table
    await database.execute("""CREATE TABLE Student(
      student_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      student_name varchar(255) NOT NULL,
      phone_number char(10),
      city varchar(255),
      state varchar(255),
      zip_code varchar(255)
      )
      """);

    // Course Table
    await database.execute("""CREATE TABLE Course(
    course_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    course_name varchar(70) NOT NULL,
    employee_id,
    department_id,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
    )
""");

    // CourseStudent Table
    await database.execute("""CREATE TABLE CourseStudent(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    course_id,
    student_id,
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
    )
""");

    print("DB Created Successfully!");
    // https://sqliteviewer.app/
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'academy.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        _onConfigure;
      },
    );
  }
}
