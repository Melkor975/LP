#header
<<
#include <string>
#include <iostream>
#include <vector>
#include <map>
using namespace std;


// struct to store information about tokens
typedef struct {
  string kind;
  string text;
} Attrib;

// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
#define createASTlist #0=new AST;(#0)->kind="list";(#0)->right=NULL;(#0)->down=_sibling;
>>

<<
#include <cstdlib>
#include <cmath>

map < string, vector <string> > M;

// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {

    attr->kind = text;
    attr->text = "";

}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind; 
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a,int n) {
 AST *c=a->down;
 for (int i=0; c!=NULL && i<n; i++) c=c->right;
 return c;
} 

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
  if (a==NULL) return;

  cout<<a->kind;
  if (a->text!="") cout<<"("<<a->text<<")";
  cout<<endl;

  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
    i=i->right;
  }
  
  if (i!=NULL) {
      cout<<s+"  \\__";
      ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
      i=i->right;
  }
}

/// print AST 
void ASTPrint(AST *a)
{
  while (a!=NULL) {
    cout<<" ";
    ASTPrintIndent(a,"");
    a=a->right;
  }
}

int evaluate(AST *a) {
	if (a == NULL) return 0;
	else if (a->kind == "intconst")
		return stoi(a->text.c_str());
	else if (a->kind == "+")
		return evaluate(child(a,0)) + evaluate(child(a,1));
}
void llegirLlista(vector<string>& ls, AST *b){
    bool acaba = child(b, 0) == NULL;
    ls.push_back(b->kind);
    for(int i = 0; !acaba ; ++i) {
        if(child(b,i)->kind == "[") llegirLlista(ls, child(b,i));
        else ls.push_back(child(b,i)->kind);
        if(child(b,i+1) == NULL) acaba = true;
    }
    ls.push_back("]");
}

void imprimeixLlista(vector<string> ls) {
    for(int i = 0; i<ls.size(); ++i) {
      
        if(ls[i] == "[" or (i == ls.size()-1)) cout << ls[i];
        else if(i+1 < ls.size() and ls[i+1] == "]") cout << ls[i];
        else cout << ls[i] << ",";
    }
    cout << endl;
}
void concat(AST *x, AST *y, vector<string>& ls) {
	vector <string> lx = M[x->kind];
	vector <string> ly = M[y->kind];
	for(int i = 0; i < lx.size()-1; ++i) {
		ls.push_back(lx[i]);
	}
	for(int j = 1; j < ly.size(); ++j) {
		ls.push_back(ly[j]);
	} 
}

void reduce(string op, AST *x, vector<string> &ls) {
		int result = 0;
		vector<string> lx = M[x->kind];
	
		if(op == "+"){
			for(int i = 0; i < lx.size(); i++) {
				if(lx[i] != "[" and lx[i] != "]") result+= stoi(lx[i]); 
			}
		}
		else if(op == "-"){
			for(int i = 0; i < lx.size(); i++) {
				if(lx[i] != "[" and lx[i] != "]") result-= stoi(lx[i]); 
			}
		}
		else if(op == "*") {
			for(int i = 0; i < lx.size(); i++) {
				if(lx[i] != "[" and lx[i] != "]") result*= stoi(lx[i]); 
			}
		}
		else cout << "No es ni suma ni resta ni multiplicacio" << endl;
		ls.push_back("[");
		ls.push_back(to_string(result));
		ls.push_back("]");
		
}

void lmap(string op, string operant, AST *x, vector<string> &ls) {
	vector <string> lx = M[x->kind];
	
	int num = stoi(operant);
	if(op == "+"){
		int aux;
		for(int i = 0; i < lx.size(); i++) {
			if(lx[i] != "[" and lx[i] != "]") {
				aux = stoi(lx[i]);
				aux += num;
				ls.push_back(to_string(aux));
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(op == "-"){
		int aux;
		for(int i = 0; i < lx.size(); i++) {
			if(lx[i] != "[" and lx[i] != "]") {
				aux = stoi(lx[i]);
				aux -= num;
				ls.push_back(to_string(aux));
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(op == "*") {
		int aux;
		for(int i = 0; i < lx.size(); i++) {
			if(lx[i] != "[" and lx[i] != "]") {
				aux = stoi(lx[i]);
				aux *= num;
				ls.push_back(to_string(aux));
			}
			else ls.push_back(lx[i]);
		}
	}
	else cout << "No es ni suma ni resta ni multiplicacio" << endl;
	
}
void lfilter(string comparador, string operant, AST *x, vector<string> &ls) {
	int num = stoi(operant);
	vector<string> lx = M[x->kind];
	if(comparador == ">") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current > num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(comparador == ">=") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current >= num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(comparador == "<") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current < num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(comparador == "<=") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current <= num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(comparador == "==") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current == num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else if(comparador == "!=") {
		int current;
		for(int i = 0; i < lx.size(); i++){
			if(lx[i] != "[" and lx[i] != "]") {
				current = stoi(lx[i]);
				if(current != num) ls.push_back(lx[i]);
			}
			else ls.push_back(lx[i]);
		}
	}
	else cout << "no es un comparador acceptat" << endl;	
}

void flat(AST *x, vector<string>& ls) {
	vector<string> lx = M[x->kind];
	ls.push_back("[");
	for(int i = 0; i < lx.size()-1; i++) {
		if(lx[i] != "[" and lx[i] != "]") ls.push_back(lx[i]);
	}
	ls.push_back("]");
}
void agafarPrimerElement(AST *x, vector<string>& ls) {
	vector<string> lx = M[x->kind];
	ls.push_back("[");
	if(lx[1] == "]"){
		cout << "EP, aquesta llista es buida, no li puc agafar cap element!" << endl;
	}
	else if(lx[1] != "[") {
		ls.push_back(lx[1]);
	}
	else  {
		int contadorClaus = 1;
		for(int i = 2; i < lx.size() and contadorClaus != 0; i++) {
			if(lx[i] == "[") contadorClaus++;
			else if(lx[i] == "]") contadorClaus--;
			ls.push_back(lx[i]);
		}
	}
	ls.push_back("]");
}
void treurePrimerElement(AST *x, vector<string>& ls) {
	vector<string> lx = M[x->kind];
	int apuntador = 0;
	ls.push_back(lx[0]);
	if(lx[1] == "]"){
		cout << "EP, aquesta llista es buida, no li puc treure cap element!" << endl;
	}
	else if(lx[1] != "[") apuntador = 2;
	else  {
		int contadorClaus = 1;
		for(int i = 2; i < lx.size() and contadorClaus != 0; i++) {
			if(lx[i] == "[") contadorClaus++;
			else if(lx[i] == "]") contadorClaus--;
			apuntador = i+1;
		}
	}
	for(int j = apuntador; j < lx.size(); j++) {
		ls.push_back(lx[j]);
	}
	
}
void execute(AST *a) {
	if(a==NULL) return;
	else if(a->kind == "=") {
		vector<string> ls;
		if(child(a,1)->kind == "[") {
			llegirLlista (ls, a->down->right);
			M[a->down->kind] = ls;
		}
		else if(child(a,1)->kind == "#") {
			concat(child(a->down->right,0), child(a->down->right,1), ls);
			M[a->down->kind] = ls;
		}
		else if(child(a,1)->kind == "lreduce") {
			reduce(a->down->right->down->kind, child(a->down->right,1), ls);
			M[a->down->kind] = ls;
		}
		else if(child(a,1)->kind == "lmap") {
			lmap(a->down->right->down->kind, a->down->right->down->right->kind,child(a->down->right,2), ls);
			M[a->down->kind] = ls;
		}
		else if(child(a,1)->kind == "lfilter") {
			lfilter(child(a, 1)->down->kind, child(a, 1)->down->down->kind, child(a,1)->down->right, ls);
			M[a->down->kind] = ls;
		}
		else if(child(a,1)->kind == "head") {
			agafarPrimerElement(child(a,1)->down, ls);
			M[a->down->kind] = ls; 
		}
	}
	else if(a->kind == "print") {
		vector<string> sprint;
		if(a->down->kind == "head") {
			agafarPrimerElement(a->down->down, sprint);
		}
        else sprint = M[a->down->kind];
        imprimeixLlista(sprint);
	}
	else if(a->kind == "flatten") {
		vector<string> ls;
		flat(a->down, ls);
		M[a->down->kind] = ls;
	}
	else if(a->kind == "pop") {
		vector<string> ls;
		treurePrimerElement(a->down, ls);
		M[a->down->kind] = ls;
	}
	
	
	if(a->right != NULL) execute (a->right);
}

int main() {
	AST *root = NULL;
	ANTLR(lists(&root), stdin);
	ASTPrint(root);
	execute(root->down);
}

>>

#lexclass START
#token NUM "[0-9]+"
#token PLUS "\+"
#token MINUS "\-"
#token MULT "\*"
#token PAR_O "\("
#token PAR_T "\)"
#token CLAU_O "\["
#token CLAU_T "\]"
#token COMA "\,"
#token CON "\#"
#token ES "\="
#token MENOR "\<"
#token MENORIGUAL "\<="
#token MAJOR "\>"
#token MAJORIGUAL "\>="
#token IGUAL "\=="
#token EMPTY "\empty"
#token DIFERENT "\!="
#token IF "if"
#token WHILE "while"
#token DO "do"
#token ENDWHILE "endwhile"
#token AND "and"
#token OR "or"
#token ENDIF "endif"
#token THEN "then"
#token NOT "not"
#token LREDUCE "lreduce"
#token LMAP "lmap"
#token LFILTER "lfilter"
#token PRINT "print"
#token FLATTEN "flatten"
#token POP "pop"
#token HEAD "head"
#token ID "[A-Za-z][A-Za-z0-9]*"




#token SPACE "[\ \n]" << zzskip();>>
lists: (list_oper)* <<#0=createASTlist(_sibling);>> ;
list_oper: c_if | c_while | void_f |  definir;


void_f: (ph |  ((PRINT^|FLATTEN^) (ph | simple_read)));
ph: ((POP^ | HEAD^) PAR_O! ID PAR_T!);

definir: ID ES^ exp;

c_if: IF^  condicio  THEN! lists ENDIF!;
c_while: WHILE^ condicio  DO! lists ENDWHILE!;

exp: (LFILTER^ cond ID)| (LREDUCE^ op_simple ID) | (LMAP^ op_simple NUM ID) | (simple_read (CON^ simple_read)*) | ph; 

op_simple: (PLUS^ | MINUS^ | MULT^);

cond: (MENOR^ | MAJOR^ | DIFERENT^ | IGUAL^) NUM;

condicio: PAR_O! (NOT^ | ) condicio_aux PAR_T!;
condicio_aux: ( (EMPTY PAR_O! simple_read PAR_T!) | (simple_read (MAJOR^ | MAJORIGUAL^ | MENOR^ | MENORIGUAL^ | IGUAL^) simple_read)) ( | (AND^ | OR^) condicio);

simple_read: ID | list;
list: (CLAU_O^ (((list | NUM) (COMA! (NUM| list))*) | )  CLAU_T!) ;

//expr: NUM (PLUS^ NUM)* ;
//down al primer fill
//right anar al seguent germa
