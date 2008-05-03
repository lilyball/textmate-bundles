/**
 * @author    ${TM_FULLNAME}
 * @copyright Copyright (c) ${TM_YEAR} ${TM_ORGANIZATION_NAME}. All rights reserved.
 * @version   $Rev$
 */
module ${TM_NEW_FILE_BASENAME};
import tango.io.Stdout;
import tango.text.convert.Format;

void main() {
	Stdout(`Hello`).newline;
}