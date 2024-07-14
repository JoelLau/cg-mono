import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormGroup, FormsModule, Validators } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { retry } from 'rxjs';

@Component({
  standalone: true,
  imports: [RouterModule, FormsModule],
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  formGroup = NewCreateShortUrlForm()

  constructor(private http: HttpClient) { }

  onSubmit(event: Event): void {
    event.preventDefault()

    if (this.formGroup.valid && this.formGroup.value.original_url) {
      this.createShortUrl(this.formGroup.value.original_url).pipe(
        retry(1)
      ).subscribe({
        error(err) { console.error(err) },
        next(response) { console.log(response) }
      })
    }
  }

  private createShortUrl(originalUrl: string) {
    return this.http.post('api/v1/short-url', { original_url: originalUrl })
  }
}

export interface CreateShortUrlRequest {
  original_url: string
}


export function NewCreateShortUrlForm() {
  return new FormGroup({
    original_url: new FormGroup('', [Validators.required])
  })
}
