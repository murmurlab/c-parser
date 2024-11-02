#include "common.hpp"
#include "c-parser.hpp"

t_type	get_type_exp(char const *exp) {
	return (
		(!std::strncmp(exp, "void", 5)) ? VOID :
		(!std::strncmp(exp, "char", 5)) ? CHAR :
		(!std::strncmp(exp, "short", 6)) ? SHORT :
		(!std::strncmp(exp, "int", 4)) ? INT :
		(!std::strncmp(exp, "long", 5)) ? LONG :
		UNDEF
	);
	
}

int	variable(char const *exp, t_variable *st) {
	for (size_t jmp = 0, i = 0; exp[i]; i+=jmp) {
		t_type type = get_type_exp(exp);
		std::printf("type: %d\n\n", type);
		break;
	}
	
	return 0;
}

int	main() {
	// extern int a;
	// int *x(void);
	// int (z)(void);
	// int (*y)(void) = &z;
	// z();
	void (*(*(d[2]))(void))(void);
	t_variable	st = { };
	variable("void (*(*(d[2]))(void))(void)", &st);

	std::printf("pointer: %lu\n", st.pointer);
	std::printf("array: %lu\n", st.array);
	std::printf("name: %s\n", st.name);
	std::printf("type: %d\n", st.type);
	// void (*x)(void) = d();
	return 0;
}
