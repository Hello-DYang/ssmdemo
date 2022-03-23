package com.yang.pojo;

import java.io.Serializable;
import java.util.Objects;

public class CaptchaResponse<T> implements Serializable {
    private String id;
    private T captcha;

    public static <T> CaptchaResponse<T> of(String id, T data) {
        return new CaptchaResponse(id, data);
    }

    public String getId() {
        return this.id;
    }

    public T getCaptcha() {
        return this.captcha;
    }

    public void setId(final String id) {
        this.id = id;
    }

    public void setCaptcha(final T captcha) {
        this.captcha = captcha;
    }

    public boolean equals(final Object o) {
        if (o == this) {
            return true;
        } else if (!(o instanceof CaptchaResponse)) {
            return false;
        } else {
            CaptchaResponse<?> other = (CaptchaResponse) o;
            if (!other.canEqual(this)) {
                return false;
            } else {
                Object this$id = this.getId();
                Object other$id = other.getId();
                if (this$id == null) {
                    if (other$id != null) {
                        return false;
                    }
                } else if (!this$id.equals(other$id)) {
                    return false;
                }

                Object this$captcha = this.getCaptcha();
                Object other$captcha = other.getCaptcha();
                if (this$captcha == null) {
                    if (other$captcha != null) {
                        return false;
                    }
                } else if (!this$captcha.equals(other$captcha)) {
                    return false;
                }

                return true;
            }
        }
    }

    protected boolean canEqual(final Object other) {
        return other instanceof CaptchaResponse;
    }


    @Override
    public int hashCode() {
        return Objects.hash(id, captcha);
    }

    @Override
    public String toString() {
        return "CaptchaResponse{" +
                "id='" + id + '\'' +
                ", captcha=" + captcha +
                '}';
    }

    public CaptchaResponse() {
    }

    public CaptchaResponse(final String id, final T captcha) {
        this.id = id;
        this.captcha = captcha;
    }
}