#include <string>

class ValueType {
public:
	typedef enum {
		tInt,
		tStr
	} Type;
private:
	int m_intVal;
	std::string m_strVal;
	ValueType::Type m_type;
public:
	ValueType(int v) : m_intVal(v), m_type(tInt), m_strVal(std::to_string(v)) {};
	ValueType(const std::string & s) : m_strVal(s), m_type(tStr), m_intVal(stoi(s)) {};

	ValueType(const ValueType & o) : m_type(o.m_type), m_strVal(o.m_strVal), m_intVal( o.m_intVal ) {};
	~ValueType() {};
	
	int intValue() const { return m_type == tInt ? m_intVal : std::stoi( m_strVal ); };
	std::string strValue() const { return m_strVal; };
};
