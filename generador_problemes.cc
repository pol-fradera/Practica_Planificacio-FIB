#include <iostream>
#include <vector>
#include <set>
#include <stack>
using namespace std;

int main () {
    int nrov,nsum,npers,npet,nase,nmag;
    nrov = npet = nase = nmag = 0;
    nsum = npers = -1;
    while (nrov < 1) {
        //cout << "Introdueix el nombre de rovers (nombre natural diferent a 0)" << endl;
        cin >> nrov;
    }
    while (nsum < 0) { 
        //cout << "Introdueix el nombre de suministres (nombre natural)" << endl;
        cin >> nsum;
    }
    if (nsum == 0) {
        while (npers < 1) {
           //cout << "Introdueix el nombre de personal (nombre natural diferent a 0)" << endl;
            cin >> npers;
        }
    }
    else {
        while (npers < 0) {
            //cout << "Introdueix el nombre de personal (nombre natural)" << endl;
            cin >> npers;
        }
    }
    while (npet <= nsum+npers) {
        //cout << "Introdueix el nombre de peticions (com a mínim: nombre de personal + nombre de suministres + 1)" << endl;
        cin >> npet;
    }
    while (nase < 1) { 
        //cout << "Introdueix el nombre d'assentaments (nombre natural positiu)" << endl;
        cin >> nase;
    }
    while (nmag < 1) { 
        //cout << "Introdueix el nombre de magatzems (nombre natural positiu)" << endl;
        cin >> nmag;
    }
    cout << "(define (problem Planificacio)\n(:domain Planificacio)\n(:objects" << endl;
    for (int i = 0; i < nrov; i++) cout << "rover" << i << " ";
    cout << "- rover" << endl;
    if (npers > 0) {
        for (int i = 0; i < npers; i++) cout << "p" << i << " ";
        cout << "- personal" << endl;
    }
    if (nsum > 0) {
        for (int i = 0; i < nsum; i++) cout << "s" << i << " ";
        cout << "- subministrament" << endl;
    }
    for (int i = 0; i < nase; i++) cout << "a" << i << " ";
    cout << "- assentament" << endl;
    for (int i = 0; i < nmag; i++) cout << "m" << i << " ";
    cout << "- magatzem\n)\n" << endl;
    cout << "(:init\n(= (prioritat_total) 0)\n(= (combustible_total) 0)" << endl;
    for (int i = 0; i < nrov; i++) {
        int x = rand()%2;
        if (x == 0) {
            x = rand()%nase;
            cout << "(= (places rover" << i << ") 0)" << endl;
            cout << "(estacionat rover" << i << " a" << x << ")" << endl;
            cout << "(= (combustible rover" << i << ") " << rand()%100 << ")" << endl;
        }
        else {
            x = rand()%nmag;
            cout << "(= (places rover" << i << ") 0)" << endl;
            cout << "(estacionat rover" << i << " m" << x << ")" << endl;
            cout << "(= (combustible rover" << i << ") " << rand()%100 << ")" << endl;
        }
    }
    for (int i = 0; i < npers; i++) {
        int x = rand()%nase;
        cout << "(disponible p" << i << " a" << x << ")" << endl;
    }
    for (int i = 0; i < nsum; i++) {
        int x = rand()%nmag;
        cout << "(disponible s" << i << " m" << x << ")" << endl;
    }
    vector<set<int>> peticions (npers+nsum);
    for (int i = 0; i < npet; i++) {
        for (int j = 0; i < npet and j < npers; j++) {
            int x = rand()%nase;
            while (!(peticions[j].insert(x).second)) x = rand()%nase;
            cout << "(peticio p" << j << " a" << x << ")" << endl;
            cout << "(prioritat" << (rand()%3)+1 << " p" << j << " a" << x << ")" << endl;
            i++;
        }
        for (int j = 0; i < npet and j < nsum; j++) {
            int x = rand()%nase;
            while (!(peticions[j+npers].insert(x).second)) x = rand()%nase;
            cout << "(peticio s" << j << " a" << x << ")" << endl;
            cout << "(prioritat" << (rand()%3)+1 << " s" << j << " a" << x << ")" << endl;
            i++;
        }
        i--;
    }
    vector<vector<bool>> camins (nase+nmag, vector<bool> (nase+nmag, false));
    stack<int> parades;
    for (int i = 0; i < nmag+nase; i++) {
        parades.push(i);
    }
    int a,b;
    b = parades.top();
    parades.pop();
    a = parades.top();
    parades.pop();
    camins[a][b] = true;
    b = a;
    while (!parades.empty()) {
        a = parades.top();
        parades.pop();
        camins[a][b] = true;
        b = a;
    }
    int max_arestes = ((nmag+nase)*(nmag+nase-1))/2;
    int arestes_extra = (max_arestes-nmag-nase+1)/3;
    //int arestes_extra = rand()%(max_arestes-nmag-nase+2);
    while (arestes_extra > 0) {
        a = rand()%(nmag+nase);
        b = rand()%(nmag+nase);
        if (!camins[a][b] and !camins[b][a] and (a != b)) {
            camins[a][b] = true;
            arestes_extra--;
        }
    }
    for (int i = 0; i < nmag+nase; i++) {
        for (int j = 0; j < nmag+nase; j++) {
            if (camins[i][j]) {
                if (i < nase and j < nase) cout << "(cami a" << i << " a" << j << ")" << endl;
                if (i < nase and j >= nase) cout << "(cami a" << i << " m" << j-nase << ")" << endl;
                if (i >= nase and j < nase) cout << "(cami m" << i-nase << " a" << j << ")" << endl;
                if (i >= nase and j >= nase) cout << "(cami m" << i-nase << " m" << j-nase << ")" << endl;
            }  
        }
    }
    cout << ")\n(:goal (and (forall (?o - personal) (entregat ?o)) (forall (?o - subministrament) (entregat ?o)))\n)" << endl;
    cout << "(:metric minimize (+ (prioritat_total) (combustible_total)))" << endl;
    cout << ")" << endl;
}
