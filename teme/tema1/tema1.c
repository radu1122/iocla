// copyright Radu-Andrei Dumitrescu 322CA 2020

#include <unistd.h>
#include <stdarg.h>						
#include <string.h>						

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

char *convert(unsigned int num, int base) 
{ 
	static char Representation[]= "0123456789abcdef";
	static char buffer[50]; 
	char *ptr; 
	
	ptr = &buffer[49]; 
	*ptr = '\0'; 
	do 
	{ 
		*--ptr = Representation[num%base]; 
		num /= base; 
	}while(num != 0); 
	
	return(ptr); 
}

int iocla_printf(const char *format, ...)
{
	va_list arg; 
	va_start(arg, format); 
	int i = 0;
	int finalLength = 0;
	while(i < strlen(format)) { 
		if (format[i] == '\\') {
			char buff[2];
			buff[0] = '\\';
			buff[1] = format[i + 1];
			i++;
			write_stdout(buff, 2);
			finalLength = finalLength + 2;
		} else if (format[i] != '%') {
			write_stdout((format + i), 1);
			finalLength++;
		} else if (format[i + 1] == '%') {
			i++;
			write_stdout((format + i), 1);
			finalLength++;
		} else if (format[i + 1] == 'd') {
			i++;
			int number = va_arg(arg, int);
			if(number < 0) { 
				number = -number;
				write_stdout("-", 1);
				finalLength++;
			} 
			char * buff = convert(number, 10);
			int buffLength = strlen(buff);
			finalLength = finalLength + buffLength;
			write_stdout(buff, buffLength);
		} else if (format[i + 1] == 'u') {
			i++;
			unsigned int number = va_arg(arg, unsigned int);
			char * buff = convert(number, 10);
			int buffLength = strlen(buff);
			finalLength = finalLength + buffLength;
			write_stdout(buff, buffLength);
		} else if (format[i + 1] == 'x') {
			i++;
			int number = va_arg(arg, int);
			char * buff = convert(number, 16);
			int buffLength = strlen(buff);
			finalLength = finalLength + buffLength;
			write_stdout(buff, buffLength);
		} else if (format[i + 1] == 'c') {
			i++;
			char s = (char)va_arg(arg, int);
			finalLength++;
			write_stdout(&s, 1);
		} else if (format[i + 1] == 's') {
			i++;
			char *s = va_arg(arg, char *);
			int buffLength = strlen(s);
			finalLength = finalLength + buffLength;
			write_stdout(s, buffLength);
		}
		i++;
	} 
	va_end(arg);
	return finalLength;
}