#if !defined(C_PARSER)
# define C_PARSER

# include "common.hpp"
# include "errors.hpp"
# include <string>

# include <errno.h>
# include <unistd.h>
# include <cstring>
# include <cstdlib>
# include <cstdio>
# include <cstring>

typedef enum	e_type {
	VOID, //0
	CHAR,
	SHORT,
	INT,
	LONG,
	UNDEF //5
}		t_type;

typedef struct	s_token_list {
	char				*gram;
	struct s_token_list	*next;
}		t_token_list;

typedef struct	s_variable {
	size_t	pointer;
	size_t	array;
	char	*name;
	t_type	type;
}		t_variable;

#endif // C_PARSER
