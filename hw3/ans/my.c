// CSCI3180 Principles of Programming Languages
// --- Declaration ---
// I declare that the assignment here submitted is original except for source material explicitly acknowledged. I also acknowledge that I am aware of University policy and regulations on honesty in academic work, and of the disciplinary guidelines and procedures applicable to
// breaches of such policy and regulations, as contained in the
// http://www.cuhk.edu.hk/policy/academichonesty/
// Assignment 3
// Name: 
// Student ID: 
// Email Addr: 

#include <stdio.h>

int creditLimit = 5000;

int repayment(char name[], int balance, int repayAmt) {

    printf("\n... Repaying debts ...\n");
    printf("Thank you, %s! ", name);

    balance -= repayAmt;

    printf("You have just repayed [HKD %d]!\n", repayAmt);

    int currentLimit = creditLimit - balance ;
    printf("Now your remaining credit limit is [HKD %d].\n", currentLimit);

    return balance;
}

int payment(char name[], int balance, int payAmt) {

    printf("\n... Consumption payment (Luk Card) ...\n");

    int currentLimit = creditLimit - balance;
    if (currentLimit < payAmt) {
        printf("You have exceeded your credit limit!\n");
        return -1;
    }

    currentLimit -= payAmt;

    balance += payAmt;

    printf("You have just payed a [HKD %d] consumption!\n", payAmt);

    printf("Now your remaining credit limit is [HKD %d].\n", currentLimit);

    return balance;
}

void regularClient(char name[], int balance, int repayAmt, int payAmt) {

    // Repaying debts
    balance = repayment(name, balance, repayAmt);

    if (balance >= 0) {
        printf("[Current card balance: HKD balance]\n");
    }
    else {
        printf("ERROR! You are trying to repay more than your debt amount!\n");
    }


    // Paying for consumption
    balance = payment(name, balance, payAmt);

    if (balance >= 0) {
        printf("[Current card balance: HKD %d]\n", balance);
    }
    else {
        printf("ERROR! You are trying to pay beyond your credit limit!\n");
    }
}

void premierClient(char name[], int balance, int repayAmt, int payAmt) {

    int creditLimit = 10000;

    printf("Dear Premier client %s, you have a credit limit of [HKD %d]! Enjoy!\n", name, creditLimit);

    regularClient(name, balance, repayAmt, payAmt);
}

void bank(char name[], char id[], int balance, int repayAmt, int payAmt) {

    printf("\n** Welcome %s **\n", name);
    printf("[Your credit card balance: HKD %d]\n", balance);

    if (id[0] == 'p') {
        premierClient(name, balance, repayAmt, payAmt);
    }
    else {
        regularClient(name, balance, repayAmt, payAmt);
    }
}

int main() {

    printf("\t\t### Welcome to the CU Bank ###\n");

    bank("Alice", "r123", 2000, 1000, 3000);
    bank("Bob", "p456", 5000, 2000, 7000);
    bank("Carol","r789", 5000, 2000, 7000);

    return 0;
}
