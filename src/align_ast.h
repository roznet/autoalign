#include <iostream>
#include <memory>
#include "align_value.hpp"

using namespace std;


class AST {
 public:
	AST() {};
	~AST() {};

	virtual int value()=0;
};

class AST_op : public AST {
 public:
	typedef enum {
		tPlus, tMinus, tMultiply, tDivide
	} OperationType;

 private:
	OperationType m_type;
	shared_ptr<AST>  m_left;
	shared_ptr<AST>  m_right;
 public:	
 AST_op(OperationType op, AST*left, AST*right) : m_left(left), m_right(right), m_type(op) {};
	~AST_op() { }

	int value() {
		switch(m_type) {
		case tPlus:
			return m_left->value() + m_right->value();
		case tMinus:
			return m_left->value() - m_right->value();
		case tMultiply:
			return m_left->value() * m_right->value();
		case tDivide:
			return m_left->value() / m_right->value();
		}
	}
};

class AST_value : public AST {
 private:
	ValueType m_value;
 public:
 AST_value(int v) : m_value(v) {};
	~AST_value() {};
	int value() { return m_value.intValue(); };
};
