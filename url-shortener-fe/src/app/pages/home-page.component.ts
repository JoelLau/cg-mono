import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import {
  FormControl,
  FormGroup,
  FormsModule,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { tap } from 'rxjs';
import {
  CreateShortUrlResponse,
  CreateShortUrlResponseError,
  CreateShortUrlResponseSuccess,
  ShortUrlApiService,
} from '../services/short-url-api/short-url-api.service';
import { StackLayoutComponent } from '../layouts/stack-layout.component';

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    StackLayoutComponent,
  ],
  templateUrl: './home-page.component.html',
  styleUrl: './home-page.component.scss',
})
export class HomePageComponent {
  formGroup = NewCreateShortUrlForm();
  errors: string[] | null = null;
  targetUrl: string | null = null;
  shortUrl: string | null = null;

  constructor(private shortUrlsApi: ShortUrlApiService) {}

  onSubmit(event: Event): void {
    event.preventDefault();

    const targetUrl = this.getTargetUrl();
    if (!this.formGroup.valid) {
      console.warn('form is not valid');
      return;
    } else if (!targetUrl) {
      console.warn(`originalUrl ${targetUrl} is not valid`);
      return;
    }

    this.shortUrlsApi
      .createShortUrl(targetUrl)
      .pipe(
        tap(() => {
          this.errors = null;
          this.targetUrl = null;
          this.shortUrl = null;
        }),
      )
      .subscribe({
        error: (err) => {
          console.error(err);
          if (!isErrorResponse(err)) {
            this.errors = [
              `unexpected error shortening URL: ${JSON.stringify(err)}`,
            ];
            return;
          }
          this.errors = err.errors;
        },
        next: (response) => {
          console.log(response);
          if (!isSuccessResponse(response)) return;
          this.targetUrl = targetUrl;
          this.shortUrl = `${this.shortUrlsApi.BASE_URL}/${response.data.short_url}`;
        },
      });
  }

  trackError(value: string) {
    return value;
  }

  private getTargetUrl() {
    return this.formGroup.value.original_url;
  }
}

export function NewCreateShortUrlForm() {
  return new FormGroup({
    original_url: new FormControl<string | null>(null, [Validators.required]),
  });
}

export function isErrorResponse(
  response: CreateShortUrlResponse,
): response is CreateShortUrlResponseError {
  return true;
}

export function isSuccessResponse(
  response: CreateShortUrlResponse,
): response is CreateShortUrlResponseSuccess {
  return true;
}
