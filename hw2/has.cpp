// # CSCI3180 Principles of Programming Languages
// # --- Declaration ---
// # I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
// # breaches of such policy and regulations, as contained in the
// # http://www.cuhk.edu.hk/policy/academichonesty/
// # Assignment 2 
// # Name: 
// # Student ID: 
// # Email Addr: 

#include "stdafx.h"
#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

class Payable {
	public:
		virtual void pay(int amount) = 0;
};

class FoodBuyer: public Payable {
public:
	void buyFood(string foodName, int amount){
		cout << "Buy " << foodName << "and pay " << amount << ".\n";
		pay(amount);
	}
};

class ClubAttendee {
public:
	virtual void attendClub() = 0;
};

class HospitalMember {
public:
	string name;
	int nbDrugsDispensed;
	HospitalMember(string _name, int _nbDrugsDispensed = 0) {
		name = _name;
		nbDrugsDispensed = _nbDrugsDispensed;
	}

	void seeDoctor(int amount){
		cout << name << " is sick! S/he sees a doctor.\n"; //This method will be overridden in the subclass!
	}

	void getDrugDispensed(int num) {
		int dispense = min(num, nbDrugsDispensed);
		nbDrugsDispensed -= dispense;
		cout << "Dispensed " << dispense << " drug items, "
			 << nbDrugsDispensed << " items still to be dispensed.\n";
	}
};

class Doctor : public HospitalMember, public FoodBuyer, public ClubAttendee {
public:
	string staffID;
	int salary = 100000;
	Doctor(string _staffID, string name):HospitalMember(name) {
		staffID = _staffID;
	}

	void seeDoctor(int amount){
		HospitalMember::seeDoctor(amount);
		nbDrugsDispensed += amount;
		cout << "Totally " << nbDrugsDispensed << " drug items administered.\n";
	}

	void getSalary(int amount){
		salary += amount;
		cout << toString() << "has got HK$" << salary << " salary left.\n";
	}

	void pay(int amount) {
		salary -= amount;
		cout << toString() << "has got HK$" << salary << " salary left.\n";
	}

	void attendClub() {
		cout << "Eat and drink in the Club.\n";
	}

	string toString() {
		return "Doctor " + name + " (" + staffID + ")";
	}
};

class Patient : public HospitalMember, public FoodBuyer {
public:
	string stuID;
	int money = 10000;
	Patient(string _stuID, string name) : HospitalMember(name) {
		stuID = _stuID;
	}

	void seeDoctor(int amount) {
		HospitalMember::seeDoctor(amount);
		nbDrugsDispensed += amount;
		nbDrugsDispensed = min(15, nbDrugsDispensed);
		cout << "Totally " << nbDrugsDispensed << " drug items administered.\n";
	}

	void pay(int amount){
		money -= amount;
		cout << toString() << " has got HK$" << money << " left in the wallet.\n";
	}

	string toString() {
		return "Patient " + name + " (" + stuID + ")";
	}
};

class Visitor : public FoodBuyer {
public:
	int money = 1000;
	string visitorID;
	Visitor(string _visitorID) {
		visitorID = _visitorID;
	}
	void pay(int amount){
		money -= amount;
		cout << toString() << " has got HK$" << money << " left in the wallet.\n";
	}

	string toString() {
		return "Visitor " + visitorID;
	}
};

class Pharmacy {
public:
	string name;
	Pharmacy(string _name){
		name = _name;
	}
	void dispenseDrugs(HospitalMember *m, int amount) {
		m->getDrugDispensed(amount);
	}

	void dispenseDrugs(Visitor* person, int _){
		cout << person->toString() << " is not a pharmacy user!\n";
	}

	string toString() {
		return name + " Pharmacy";
	}
};

class Canteen {
public:
	string name;
	Canteen(string _name) {
		name = _name;
	}
	void sellNoodle(FoodBuyer *buyer) {
		buyer->buyFood("Noodle", 40);
	}
	string toString(){
		return "Canteen " + name;
	}
};

class Department{
public:
	string name;
	Department(string _name) {
		name = _name;
	}

	void callPatient(Doctor* person, int amount) {
		person->seeDoctor(amount);
	}
	void callPatient(Patient* person, int amount) {
		person->seeDoctor(amount);
	}
	void callPatient(Visitor* person, int _){
		cout << person->toString() << " has no rights to get see a doctor!\n";
	}

	void paySalary(Doctor *doctor, int amount) {
		cout << toString() << " pays Salary " << amount << " to " << doctor->toString() << ".\n";
		doctor->getSalary(amount);
	}
	void paySalary(Patient* person, int _){
		cout << person->toString() << " has no rights to get salary from " << toString() << "!\n";
	}
	void paySalary(Visitor* person, int _){
		cout << person->toString() << " has no rights to get salary from " << toString() << "!\n";
	}
	string toString(){
		return name + " Department";
	}
};

class StaffClub {
public:
	string clubName;
	StaffClub(string _name){
		clubName = _name;
	}

	void holdParty(ClubAttendee *person) {
		person->attendClub();
	}
	void holdParty(Patient* person) {
		cout << person->toString() << " has no rights to use facilities in the Club!\n";
	}
	void holdParty(Visitor* person) {
		cout << person->toString() << " has no rights to use facilities in the Club!\n";
	}
	string toString() {
		return clubName + " Club";
	}
};

int _tmain(int argc, _TCHAR* argv[])
{
	cout << "Hospital Administration System: \n";
	Patient* alice = new Patient("p001", "Alice");
	Doctor* bob = new Doctor("d001", "Bob");
	Visitor* visitor = new Visitor("v001");
	Pharmacy* mainPharm = new Pharmacy("Main");
	Canteen* bigCanteen = new Canteen("Big Big");
	Department* AnE = new Department("A&E");
	StaffClub* teaClub = new StaffClub("Happy");

	#define RUN(person) \
		cout << "\n"; \
		cout << person->toString() << " enter CU Hospital ...\n"; \
		cout << person->toString() << " enter " << AnE->toString() << ".\n"; \
		AnE->callPatient(person, 20); \
		cout << person->toString() << " enters " << mainPharm->toString() << ".\n"; \
		mainPharm->dispenseDrugs(person, 10); \
		mainPharm->dispenseDrugs(person, 25); \
		cout << person->toString() << " enters " << bigCanteen->toString() << ".\n"; \
		bigCanteen->sellNoodle(person); \
		cout << person->toString() << " enters " << AnE->toString() << ".\n"; \
		AnE->paySalary(person, 10000); \
		cout << person->toString() << " enters " << teaClub->toString() << ".\n"; \
		teaClub->holdParty(person);

	RUN(alice);
	RUN(bob);
	RUN(visitor);

	while (true);
	return 0;
}

