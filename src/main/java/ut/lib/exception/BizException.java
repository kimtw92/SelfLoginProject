package ut.lib.exception;

public class BizException extends Exception {

	/**
	 *
	 */

	public BizException(String message, Exception exception) {
		super(message, exception);
	}

	public BizException(String message) {
		this(message, null);
	}

	public BizException(Exception exception) {
		this(null, exception);
	}
}
